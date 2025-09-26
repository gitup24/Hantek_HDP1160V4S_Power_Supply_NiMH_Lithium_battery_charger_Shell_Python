import sys
from hantekpsu import PSU

# --- Check if the script is running inside the virtual environment ---
# The environment should be activated, so the 'hantekpsu' package is available.
try:
    # Set the correct serial port and baud rate for your PSU
    SERIAL_PORT = '/dev/ttyUSB0'
    BAUD_RATE = 2400

    print(f"Connecting to Hantek PSU on port {SERIAL_PORT}...")
    p = PSU(port=SERIAL_PORT, baudrate=BAUD_RATE)
    print("Connection successful!")

    # 1. Set the output voltage
    TARGET_VOLTAGE = 12.0
    print(f"Setting output voltage to {TARGET_VOLTAGE}V...")
    p.set_output_voltage(TARGET_VOLTAGE)

    # 2. Get and print the model information
    model = p.get_model()
    print(f"PSU Model: {model}")

    # Optional: Get current settings
    print(f"Current Output Voltage: {p.get_active_current()}V")
    print(f"Current Output Current: {p.get_active_current()}A")

except ImportError:
    print("ERROR: 'hantekpsu' module not found.")
    print("Make sure you run this script after the shell script has created and activated the virtual environment.")
    sys.exit(1)
except Exception as e:
    print(f"An error occurred while communicating with the PSU: {e}")
    print("Please check that the PSU is connected and that you have the correct permissions for the serial port ('/dev/ttyUSB0').")
    sys.exit(1)
