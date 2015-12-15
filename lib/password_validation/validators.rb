class PasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attr, password)
    opts = {
      length: {minimum: 8, message: ->(opts, _) { "must be at least #{opts[:minimum]} characters" }},
      uppercase: {required: true, message: 'must include an uppercase letter (A-Z)'},
      lowercase: {required: true, message: 'must include a lowercase letter (a-z)'},
      numeral: {required: true, message: 'must include a number (0-9)'},
      special: {required: true, pattern: /[`~!@#$%\^&*()\-_=+\[\]{}\\|;:'",.<>\/?]/, message: ->(opts, _) {
        list = opts[:pattern].source[1..-2].gsub('\\', '')
        if opts[:pattern].source.include?('\\\\')
          list << '\\'
        end
        "must include one of these special characters: #{list}"
      }}
    }.deep_merge(options)
    
    errors = record.errors[attr]
    if password
      maybe_validate_length    password, errors, opts
      maybe_validate_lowercase password, errors, opts
      maybe_validate_uppercase password, errors, opts
      maybe_validate_numeral   password, errors, opts
      maybe_validate_special   password, errors, opts
    end
  end
  
  private    
  
  def maybe_validate_length(password, errors, opts)
    if opts[:length] and opts[:length][:minimum]
      if password.length < opts[:length][:minimum]
        errors << message(opts[:length], password)
      end
    end
  end
  
  def maybe_validate_lowercase(password, errors, opts)
    if opts[:lowercase] and opts[:lowercase][:required]
      unless password.match(/[a-z]/)
        errors << message(opts[:lowercase], password)
      end
    end
  end
  
  def maybe_validate_numeral(password, errors, opts)
    if opts[:numeral] and opts[:numeral][:required]
      unless password.match(/[0-9]/)
        errors << message(opts[:numeral], password)
      end
    end
  end
  
  def maybe_validate_special(password, errors, opts)
    if opts[:special] and opts[:special][:pattern] and opts[:special][:required]
      unless password.match(opts[:special][:pattern])
        errors << message(opts[:special], password)
      end
    end
  end
  
  def maybe_validate_uppercase(password, errors, opts)
    if opts[:uppercase] and opts[:uppercase][:required]
      unless password.match(/[A-Z]/)
        errors << message(opts[:uppercase], password)
      end
    end
  end
  
  def message(opts, password)
    if opts[:message].is_a? Proc
      opts[:message].call opts, password
    else
      opts[:message]
    end
  end
end