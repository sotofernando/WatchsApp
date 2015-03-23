# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require "rubygems"
require 'bundler'
Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.

  # app.deployment_target = '8.1'
  # ShopList2Ord
  # 2 Order List
  app.name = 'WatchsApp'
  app.identifier = 'com.sotofernando.WatchsApp'
  app.codesign_certificate = 'iPhone Developer: Fernando Soto Villaran (8N59NNTU76)'
  app.provisioning_profile = '~/provisioning/WatchsApp.mobileprovision'
  app.icons = ['WatchsApp.png', 'WatchsApp@2x.png']
  # app.icons = ["Icon.png",    # <- iPhone non-retina standard icon
  #           "Icon@2x.png"] # <- Retina iPhone iconend
end