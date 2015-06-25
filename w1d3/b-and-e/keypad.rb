class Keypad
  attr_reader :key_history, :code_bank, :code, :code_length, :mode_keys

  def initialize(code_length = 4, code_bank = [])
    @key_history = []
    @code_bank = code_bank
    @mode_keys = [1,2,3]
    @code_length = code_length
    @code = generate_code
    @num_presses = 0
  end

  def self.full_key_bank
    codes = []
    (0..10**4).each do |i|
      codes << ("%04d" % i).split("").map(&:to_i)
    end
    Keypad.new(4,codes)
  end

  def generate_code
    code = []
    @code_length.times { code << rand(9) }
    p code
    code
  end

  def press(key)
    @num_presses += 1
    puts "Num presses: #{@num_presses}" if @num_presses % 1000 == 0
    result = @mode_keys.include?(key) ? check_code(@key_history[-@code_length..-1]) : nil
    @key_history << key
    trim_key_history
    if result
      puts "beep"
      return true
    end
  end

  def check_code(code)
    @code_bank << code
    return true if code == @code
    false
  end

  def all_codes_entered?
    #Come back to this and try other way too!
    (0...10**@code_length).each do |code_integer|
      code = "%04d" % code_integer
      return false if !@code_bank.include?(code.split("").map(&:to_i))
    end
    true
  end

  def trim_key_history
    @key_history = @key_history[-(@code_length+1)..-1] if @key_history.size > @code_length + 1
  end

end
