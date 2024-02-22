class UsersController < ApplicationController
  def show
    @user = User.find_by!(username: params.fetch(:username))
  end

  def liked
    @user = User.find_by!(username: params.fetch(:username))
  end

  def feed
    @user = User.find_by!(username: params.fetch(:username))
  end

  def following
    @user = User.find_by!(username: params.fetch(:username))

    render "users_list", locals: {users_list: @user.leaders}
  end

  def followers
    @user = User.find_by!(username: params.fetch(:username))

    render "users_list", locals: {users_list: @user.followers}
  end
end
