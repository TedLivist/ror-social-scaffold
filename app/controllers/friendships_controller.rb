class FriendshipsController < ApplicationController
  before_action :update_params, only: [:update]

  def create
    friend = User.find(params[:friend_id])

    check_friend = current_user.friendships.find_by(friend_id: friend.id)
    if check_friend
      flash[:alert] = 'You have added that friend'
      redirect_to root_path and return
    else
      new_friend = current_user.friendships.build(friend_id: friend.id, status: 'pending')

      redirect_to root_path and return if new_friend.save

      render body: 'Not saved'
    end
  end

  def update
    friendship_to_update = Friendship.find(params[:id])

    if friendship_to_update.update(update_params)
      flash[:notice] = 'You are now friends. Hooray! :)'
      redirect_to root_path and return
    else
      flash[:alert] = 'You are friends already!'
      redirect_to posts_path
    end
  end

  def destroy
    @invitee = User.find(params[:user_id])
    friend_request = @invitee.friendships.find_by(friend_id: current_user.id)

    friend_request.destroy
    flash[:alert] = 'You have rejected the friend request'
    redirect_to root_path and return
  end

  private

  def update_params
    params.permit(:user_id, :friend_id, :status)
  end
end
