#ifndef PTIMER_H
#define PTIMER_H

#include <stdint.h>
#include "cpu.h"

typedef volatile struct __attribute__((packed, aligned(4))){
    uint32_t LR;            /* 0x0 Private timer load register */
    uint32_t CR;            /* 0x4 Private timer counter register */
    uint32_t CTRL;          /* 0x8 Private tiemr control register */
    uint32_t ISR;           /* 0xC Private timer interrupt status register */
} private_timer_registers;

typedef enum {
    PTIMER_OK = 0,
    PTIMER_INVALID_PERIOD
} ptimer_error;

#define PTIMER_BASE ((cpu_get_periphbase() + PTIMER_OFFSET))

#define CTRL_IRQ_ENABLE     (1 << 2u)
#define CTRL_AUTORELOAD     (1 << 1u)
#define CTRL_ENABLE         (1u)

#define ISR_CLEAR           (1u)

#define PTIMER_INTERRUPT    (29u)

void ptimer_isr(void);
ptimer_error ptimer_init(uint16_t millisecs);

#endif
