#include <stdbool.h>
#include "ptimer.h"
#include "irq.h"
#include "systime.h"

static private_timer_registers* regs;
static const uint32_t refclock = 24000000u; /* 24 MHz */

/* 
 *
 *
 * the private timer period from the manual
 *
 * (prescaler + 1) * (load value + 1)
 * ----------------------------------
 *          refclock
 *
 * */

static bool validate_config(uint16_t millisecs){
    /* very simpified assume prescalar at 0
     * then largest possible numerator is UINT32_MAX*/
    uint32_t max_period = UINT32_MAX / refclock;
    uint32_t max_millis = max_period * 1000u;

    return millisecs < max_millis;
}

static uint32_t millisecs_to_tiemr_value(uint16_t millisecs){
    double period = millisecs * 0.001;
    uint32_t value = (period * refclock) - 1;
    value *= 3; /* additional qemu slowdown factor */

    return value;
}

ptimer_error ptimer_init(uint16_t millisecs){
    regs = (private_timer_registers*)PTIMER_BASE;
    if(!validate_config(millisecs)){
        return PTIMER_INVALID_PERIOD;
    }
    uint32_t load_val = millisecs_to_tiemr_value(millisecs);
    WRITE32(regs->LR, load_val); /* Load the intial tiemr value */

    /* register the interrupt */
    (void)irq_register_isr(PTIMER_INTERRUPT, ptimer_isr);

    uint32_t ctrl = CTRL_AUTORELOAD | CTRL_IRQ_ENABLE | CTRL_ENABLE;
    WRITE32(regs->CTRL, ctrl);/* configure and start the timer */

    return PTIMER_OK;
}

void ptimer_isr(void){
    WRITE32(regs->ISR, ISR_CLEAR);/* clear the interrupt */
    systime_tick();
}
