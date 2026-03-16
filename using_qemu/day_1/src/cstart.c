#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include "uart_pl011.h"
#include "cpu.h"
#include "gic.h"
#include "ptimer.h"
#include "tasks.h"
#include "sched.h"

int main(){
    uart_config config ={
        .data_bits = 8,
        .stop_bits = 1,
        .parity = false,
        .baudrate = 9600
    };
    uart_configure(&config);

    uart_putchar('A') ;
    uart_putchar('B');
    uart_putchar('C');
    uart_putchar('\n');

    uart_write("Welcome to chapter 8, scheduler!\n");
    gic_init();
    gic_enable_interrupt(UART0_INTERRUPT);
    gic_enable_interrupt(PTIMER_INTERRUPT);
    cpu_enable_interrupts();

    if(ptimer_init(1u) != PTIMER_OK){
        uart_write("Failed to initialize cpu timer!!");
    }

    (void)sched_add_task(&task0, 5000u);
    (void)sched_add_task(&task1, 2000u);

    // task 2 will hang a cooperative scheduler
    // uncomment below to see how it fails
    // (void)sched_add_task(&task2, 9000u);
    
    sched_run();
    
    return 0;
}
