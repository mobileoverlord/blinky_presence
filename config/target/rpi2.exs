use Mix.Config

config :blinky_presence,
  led: :red

config :nerves_io_led, names: [ red: "led0", green: "led1" ]
