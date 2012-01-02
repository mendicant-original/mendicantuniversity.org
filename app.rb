require 'sinatra'
require 'haml'
require 'sass'
require 'compass'

configure do
  Compass.configuration do |config|
    config.project_path = File.dirname(__FILE__)
    config.sass_dir = 'stylesheets'
  end

  set :haml, { :format => :html5 }
  set :sass, Compass.sass_engine_options
  set :markdown, { :layout_engine => :haml }
end

helpers do
  # This is the only way to get the sass helper to look in a directory
  # other than `views` for the sass stylesheets
  def sass(template, options={}, locals={})
    options.merge! :views => "stylesheets"
    super(template, options, locals)
  end
end

get('/') { haml :index }

# About

get('/about/courses.?:format?') do
  @title = "Courses"
  markdown :'about/courses'
end

get('/about/admissions.?:format?') do
  @title = "Admissions"
  markdown :'about/admissions'
end

get('/about/calendar.?:format?') do
  @title = "Calendar"
  haml :'about/calendar'
end

get('/about/staff.?:format?') do
  @title = "Staff"
  markdown :'about/staff'
end

get('/about/history.?:format?') do
  @title = "History"
  markdown :'about/history'
end

get('/about/contact.?:format?') do
  @title = "Contact Us"
  markdown :'about/contact'
end

# Resources

get('/resources/learning_materials.?:format?') do
  @title = "Learning Materials"
  markdown :'resources/learning_materials'
end

get('/resources/core_projects.?:format?') do
  @title = "Core Projects"
  markdown :'resources/core_projects'
end

get('/resources/student_projects.?:format?') do
  @title = "Student Projects"
  markdown :'resources/student_projects'
end

get '/stylesheets/screen.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :screen
end

get '/*' do
  url = "http://school.mendicantuniversity.org"
  url += "/#{params[:splat].first}" if params[:splat] && params[:splat].first

  redirect url
end