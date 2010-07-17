# Include hook code here
require 'active_record'
require 'has_delegates'

ActiveRecord::Base.send(:include, HasDelegates)
