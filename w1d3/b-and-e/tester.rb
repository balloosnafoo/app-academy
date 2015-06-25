require_relative 'keypad'

class KeypadTester
  def initialize(keypad)
    @keypad = keypad
    @code_length = keypad.code_length
    @mode_keys = keypad.mode_keys
    @code_bank = Hash.new(false)
  end

  def run
    output_code = nil
    (0...10**@code_length).each do |code_integer|
      code = "%04d" % code_integer
      code = code.split("").map(&:to_i)
      return code if try_code(code)
    end
    #puts "All codes have been accounted for, and the correct code is:" if @keypad.all_codes_entered?
    #output_code
  end

  def try_code(queue)
    code = queue.dup
    code << @mode_keys.first
    (@code_length + 1).times do
      return true if @keypad.press(code.shift)
    end
    false
  end

end
