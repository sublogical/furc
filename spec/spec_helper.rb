#--
#
# Copyright (c) 2009 by Thoughtcrime, llc. All Rights Reserved.
#
# File name: spec_helper.rb
# Author:    Jay Hoover
# Date:      11/22/2009
#
#++
#
# === File Description
# For running spec files
#

require 'rubygems'
$TESTING=true
$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'furc'
