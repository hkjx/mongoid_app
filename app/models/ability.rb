class Ability
	include CanCan::Ability

	def initialize(user)
		user||=User.new

		can :read, :all
		if user.role == "admin"
			can :manage, :all
		elsif user.role == "moderator"
			can :manage, Comment
		elsif user.role == "author"	
			can :create, Article
			can :edit, Article do |a|
				a.user==user
			end
			can :delete, Article do |a|
				a.user==user
			end		
		elsif user.role == "user"	
			can :create, Comment
			can :edit, Comment do |a|
				a.user==user
			end
			can :delete, Comment do |a|
				a.user==user
			end					
		end
	end
end
  
