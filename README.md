# RailsCasts Episode #393: Guest User Record

http://railscasts.com/episodes/393-guest-user-record

### tasks#update

```coffee
jQuery ->
  $('.edit_task label input[type=checkbox]').click ->
    $.ajax                                        # request url
      url: $(this).parent('label').parent('form')[0].action
      headers:                                    # request header
        Accept: 'text/javascript; charset=utf-8'
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
      type: 'PATCH'                               # http 动词
      data:
        'task[complete]': $(this).is(':checked')  # 得到 boolean 值
        'authenticity_token': $(this).siblings('#authenticity_token').val()

```

Processing by TasksController#update as JS

```shell
Started PATCH "/tasks/17" for 127.0.0.1 at 2018-02-08 00:52:09 +0800
Processing by TasksController#update as JS
  Parameters: {"task"=>{"complete"=>"true"}, "id"=>"17"}
  User Load (0.1ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
  Task Load (0.1ms)  SELECT  "tasks".* FROM "tasks" WHERE "tasks"."user_id" = ? AND "tasks"."id" = ? LIMIT ?  [["user_id", 1], ["id", 17], ["LIMIT", 1]]
   (0.0ms)  begin transaction
  SQL (0.3ms)  UPDATE "tasks" SET "complete" = ? WHERE "tasks"."id" = ?  [["complete", "t"], ["id", 17]]
   (1.3ms)  commit transaction
  Rendering tasks/update.js.erb
  Rendered tasks/update.js.erb (0.4ms)
Completed 200 OK in 14ms (Views: 6.2ms | ActiveRecord: 1.9ms)
```

## user model

```ruby
class User < ApplicationRecord
  has_many :tasks, dependent: :destroy


  validates_presence_of :username, :email, unless: :guest?
  validates_uniqueness_of :username, allow_blank: true
  validates_confirmation_of :password

  has_secure_password validations: false

  def self.new_guest
    new { |u| u.guest = true }
  end

  def name
    guest ? "Guest" : username
  end

  def move_to(user)
    tasks.update_all(user_id: user.id)
  end
end

```

## users controller

```ruby
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = params[:user] ? User.new(user_params) : User.new_guest
    if @user.save
      current_user.move_to(@user) if current_user && current_user.guest?
      session[:user_id] = @user.id
      flash[notice] = "Sign up successfully!" unless current_user.guest?
      redirect_to root_path
    else
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end

```

![](https://ws3.sinaimg.cn/large/006tNc79ly1fo8dheab61j31kw0s3wk0.jpg)

## 参考链接
[1] https://5minutenpause.com/blog/2014/03/28/submit-remote-forms-with-jquery-in-rails/

[2] https://stackoverflow.com/questions/5317664/jquery-form-post-converts-boolean-checkboxes-to-on-and-off
