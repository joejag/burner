require "rubygems"
require "bundler/setup"
require "sinatra"
require "sinatra/reloader"
require 'sinatra/activerecord'
require "erb"
require 'json'
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
require File.dirname(__FILE__) + "/my_app.rb"

set :run, false
set :raise_errors, true
set :database, "sqlite3:///burnup.db"

use ActiveRecord::ConnectionAdapters::ConnectionManagement

run MyApp.new
