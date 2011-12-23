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

get '/changelog.?:format?' do
  url = "http://school.mendicantuniversity.org/changelog"
  url += ".#{params[:format]}" if params[:format]

  redirect url
end

# About

get('/about/courses.?:format?')    { markdown :'about/courses'    }
get('/about/admissions.?:format?') { markdown :'about/admissions' }
get('/about/staff.?:format?')      { markdown :'about/staff'      }
get('/about/contact.?:format?')    { markdown :'about/contact'    }

# Resources

get('/resources/learning_materials.?:format?') do
  markdown :'resources/learning_materials'
end

get('/resources/core_projects.?:format?') do
  markdown :'resources/core_projects'
end

get('/resources/student_projects.?:format?') do
  markdown :'resources/student_projects'
end

get '/alumni/?:path?' do
  url = "http://school.mendicantuniversity.org/alumni"
  url += "/#{params[:path]}" if params[:path]

  redirect url
end

get '/stylesheets/screen.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :screen
end