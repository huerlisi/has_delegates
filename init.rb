# Include hook code here
require 'has_delegates'

ActiveRecord::Base.send(:include, HasDelegates)
