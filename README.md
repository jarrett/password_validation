# Password Validation for Rails and ActiveModel

This gem provides `validates :password` for any `ActiveModel` class (including Rails
models).

## Installation

Put this in your Gemfile:

`gem 'password_validation'`

Then run `bundle install`.

## Basic Usage

The simplest way to use the validator is like this:

    class User < ActiveRecord::Base
      validates :password, password: true
    end

## Defaults

The default requirements are:

* At least eight characters.
* At least one uppercase character.
* At least one lowercase character.
* At least one numeral.
* At least one special character.

A default error message is provided for each.

## Customization

The requirements and the error message can be customized by passing an options hash:
    
    # Override the default length requirement.
    validates :password, password: length: {minimum: 10}}
    
    # Turn off the uppercase requirement.
    validates :password, password: {uppercase: {required: false}}
    
    # Turn off the lowercase requirement.
    validates :password, password: {lowercase: {required: false}}
    
    # Turn off the numeral requirement.
    validates :password, password: {numeral: {required: false}}
    
    # Turn off the special character requirement.
    validates :password, password: {special: {required: false}}
    
    # Use a custom message. This works not just for length but for all requirements.
    validates uppercase: {message: 'needs an uppercase letter'}
    
    # Dynamically generate a message from a proc. The first parameter is the options hash
    # with the gem's default settings merged in. The second is the password.
    validates length: {message: ->(opts, p) {
      "#{p} is too short. Must be at least #{opts[:minimum]} characters."
    }}

## Conditional Validation

In many applications, you don't want to validate the password every time the record is
saved. Instead, you want to validate only when the record is created or the password is
being changed. So you might consider something like this:

    class User < ActiveRecord::Base
      validates :password, password: true, if: require_password?
      
      def require_password?
        password.present? or new_record?
      end
    end