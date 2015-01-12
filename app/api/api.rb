require 'helpers'

class API < Grape::API
  version 'v1', using: :path
  format :json
  prefix :api

  helpers APIHelpers

  params do
    requires :token
  end
  get 'ideas' do
    authenticate!
    Idea.includes(:creator).as_json(include: [:creator])
  end

  params do
    requires :token
  end
  get 'ideas/:id' do
    authenticate!
    idea = Idea.find(params[:id])
    if idea.present?
      idea
    else
      error!({error: "cant find such idea"}, 404)
    end
  end

  params do
    requires :token
  end
  post 'ideas/:id/up' do
    authenticate!
    idea = Idea.find(params[:id])
    if idea.present?
      idea.score = idea.score + 1
      idea.save
    else
      error!({error: "cant find such idea"}, 404)
    end
  end

  params do
    requires :token
  end
  post 'ideas/:id/down' do
    authenticate!
    idea = Idea.find(params[:id])
    if idea.present?
      idea.score = idea.score - 1
      idea.save
    else
      error!({error: "cant find such idea"}, 404)
    end
  end

  params do
    requires :username
    requires :password
    requires :password_confirmation
  end
  post 'signup' do
    u = User.new(
      username: params[:username],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    if u.save
      u
    else
      error!({error: u.errors}, 422)
    end
  end

  params do
    requires :username
    requires :password
  end
  post 'login' do
    expect = User.find_by(username: params[:username]).try(:authenticate, params[:password])
    if expect
      expect
    else
      error!({error: "Username pwd combination not found"}, 401)
    end
  end
end
