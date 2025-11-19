#include "libopencm3/stm32/rcc.h"
#include "libopencm3/stm32/gpio.h"
#include <libopencm3/stm32/memorymap.h>
#include <libopencm3/cm3/vector.h>

#include "core/uart.h"
#include "core/system.h"
#include "core/simple-timer.h"
#include "comms.h"
#include "bl-flash.h"

#define UART_PORT   (GPIOA)
#define RX_PIN      (GPIO3)
#define TX_PIN      (GPIO2)

#define BOOTLOADER_SIZE        (0x8000U)
#define MAIN_APP_START_ADDRESS (FLASH_BASE + BOOTLOADER_SIZE)

static void jump_to_main(void){
  rcc_periph_clock_enable(RCC_GPIOA);
  vector_table_t* main_vector_table = (vector_table_t*)(MAIN_APP_START_ADDRESS);
  main_vector_table->reset();
}

int main(void) {
  system_setup();
  // gpio_setup();
  // uart_setup();
  // comms_setup();

  simple_timer_t timer;
  simple_timer_setup(&timer, 1000, true);
  
  while(true){
    if(simple_timer_has_elapsed(&timer)){
      volatile int x = 0;
      x++;
    }
  }

  // TODO: Teardown


  jump_to_main();

  // Never return
  return 0;
}
