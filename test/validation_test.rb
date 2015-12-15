require 'test_helper'

class ValidationTest < Minitest::Test  
  # All requirements met
  
  def test_valid_password
    assert_errors [], '$Abc1234'
  end
  
  # Length
  
  def test_length_defaults
    assert_errors 'must be at least 8 characters', '$Abc123'
    assert_errors 'must be at least 8 characters', '$Abc123', true
  end
  
  def test_length_minimum
    assert_errors 'must be at least 10 characters', '$Abc123', length: {minimum: 10}
  end
  
  def test_length_message
    assert_errors 'at least 8', '$Abc123', length: {message: ->(opts, _) { "at least #{opts[:minimum]}" }}
    assert_errors '$Abc123 is too short', '$Abc123', length: {message: ->(_, p) { "#{p} is too short" }}
    assert_errors 'at least eight', '$Abc123', length: {message: 'at least eight'}
  end
  
  # Lowercase
  
  def test_lowercase_defaults
    assert_errors 'must include a lowercase letter (a-z)', '$ABCD123'
    assert_errors 'must include a lowercase letter (a-z)', '$ABCD123', true
  end
  
  def test_lowercase_required
    assert_errors 'must include a lowercase letter (a-z)', '$ABCD123', lowercase: {required: true}
    assert_errors [], '$ABCD123', lowercase: {required: false}
  end
  
  def test_lowercase_message
    assert_errors 'needs a lowercase', '$ABCD123', lowercase: {message: 'needs a lowercase'}
  end
  
  # Uppercase
  
  def test_uppercase_defaults
    assert_errors 'must include an uppercase letter (A-Z)', '$abcd123'
    assert_errors 'must include an uppercase letter (A-Z)', '$abcd123', true
  end
  
  def test_uppercase_required
    assert_errors 'must include an uppercase letter (A-Z)', '$abcd123', uppercase: {required: true}
    assert_errors [], '$abcd123', uppercase: {required: false}
  end
  
  def test_uppercase_message
    assert_errors 'needs an uppercase', '$abcd123', uppercase: {message: 'needs an uppercase'}
  end
  
  # Numeral
  
  def test_numeral_defaults
    assert_errors 'must include a number (0-9)', '$Abcdefg'
    assert_errors 'must include a number (0-9)', '$Abcdefg', true
  end
  
  def test_numeral_required
    assert_errors 'must include a number (0-9)', '$Abcdefg', numeral: {required: true}
    assert_errors [], '$Abcdefg', numeral: {required: false}
  end
  
  def test_numeral_message
    assert_errors 'needs a number', '$Abcdefg', numeral: {message: 'needs a number'}
  end
  
  # Special character
  
  def test_special_defaults
    assert_errors(
      %Q(must include one of these special characters: `~!@#$%^&*()-_=+\[]{}|;:'",.<>/?\\),
      '1Abcdefg'
    )
    assert_errors(
      %Q(must include one of these special characters: `~!@#$%^&*()-_=+\[]{}|;:'",.<>/?\\),
      '1Abcdefg', true
    )
  end
  
  def test_special_required
    assert_errors(
      %Q(must include one of these special characters: `~!@#$%^&*()-_=+\[]{}|;:'",.<>/?\\),
      '1Abcdefg',
      special: {required: true}
    )
    assert_errors [], '1Abcdefg', special: {required: false}
  end
  
  def test_special_message
    assert_errors 'needs a special character', '1Abcdefg', special: {message: 'needs a special character'}
  end
end