# module ApplicationCable
#   class Connection < ActionCable::Connection::Base
#     # we always create a connection, and use the session_id to identify it.
#     #identified_by :session
#
#     # def connect
#     #   #self.session = cookies.encrypted[Rails.application.config.session_options[:key]]
#     # end
#   end
# end

require 'set'
if RUBY_ENGINE == 'opal'
  require "hyper-react"
  require 'hyper-operation'
  require 'active_support'
  require 'time'
  require 'date'
  require 'kernel/itself' unless Object.instance_methods.include?(:itself)
  require "reactive_record/active_record/error"
  require "reactive_record/server_data_cache"
  require "reactive_record/active_record/reactive_record/while_loading"
  require "reactive_record/active_record/reactive_record/operations"
  require 'synchromesh/broadcast'
  require "reactive_record/active_record/reactive_record/isomorphic_base"
  require 'reactive_record/active_record/reactive_record/dummy_value'
  require 'reactive_record/active_record/reactive_record/column_types'
  require "reactive_record/active_record/aggregations"
  require "reactive_record/active_record/associations"
  require "reactive_record/active_record/reactive_record/base"
  require "reactive_record/active_record/reactive_record/reactive_set_relationship_helpers"
  require "reactive_record/active_record/reactive_record/collection"
  require "reactive_record/active_record/reactive_record/scoped_collection"
  require "reactive_record/active_record/reactive_record/unscoped_collection"
  require "reactive_record/active_record/class_methods"
  require "reactive_record/active_record/instance_methods"
  require "reactive_record/active_record/base"
  require "reactive_record/interval"
  require_relative 'reactive_record/scope_description'
  require_relative 'active_record_base'
  require_relative 'hypermesh/version'
  require_relative 'opal/parse_patch'
  require_relative 'opal/set_patches'
  require_relative 'opal/equality_patches'
else
  require 'opal'
  require 'hyper-react'
  require 'hyper-operation'
  require "reactive_record/permissions"
  #require "reactive_record/engine"
  require "reactive_record/server_data_cache"
  require "reactive_record/active_record/reactive_record/operations"
  require 'synchromesh/broadcast'
  require "reactive_record/active_record/reactive_record/isomorphic_base"
  require "reactive_record/active_record/public_columns_hash"
  require "reactive_record/serializers"
  require "reactive_record/pry"
  require_relative 'active_record_base'
  require 'hypermesh/version'
  #require 'synchromesh/connection'
  #require 'synchromesh/synchromesh'
  #require 'synchromesh/policy'
  #require 'synchromesh/synchromesh_controller'

  Opal.append_path File.expand_path('../sources/', __FILE__).untaint
  Opal.append_path File.expand_path('../', __FILE__).untaint
  Opal.append_path File.expand_path('../../vendor', __FILE__).untaint
end
require 'enumerable/pluck'
#require_relative 'synchromesh/client_drivers'
