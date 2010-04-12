require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  has_many :ingredients, :through => :user_ingredients
  has_many :recipe_ratings
  has_many :recipe_comments

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  before_create :make_activation_code 

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation


  # Activates the user in the database.
  def activate!
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def active?
    # the existence of an activation code means they have not activated yet
    activation_code.nil?
  end

  def is_admin?
    self.is_admin
  end
  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find :first, :conditions => ['login = ? and activated_at IS NOT NULL', login] # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  def create_reset_code
      @reset = true
      self.update_attribute(:reset_code, Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join ))
      #logger.debug self.reset_code
      #save(false)
    end 

    def recently_reset?
      @reset
    end 
    
    def delete_reset_code
      self.update_attribute(:reset_code, nil)
      #save(false)
    end

    def prepopulate(id)
      
      #chicken = 2
      chicken = UserIngredient.new(:user_id => id, :ingredient_id =>2 , :unit => "kg", :qty => 1 )
      chicken.save

      #potato = 4
      potato = UserIngredient.new(:user_id => id, :ingredient_id =>4 , :unit => "kg", :qty => 1 )
      potato.save

      #onion = 5
      onion = UserIngredient.new(:user_id => id, :ingredient_id =>5 , :unit => "kg", :qty => 2 )
      onion.save

      #7 = spinach
      spinach = UserIngredient.new(:user_id => id, :ingredient_id =>7 , :unit => "g", :qty => 500 )
      spinach.save

      #garlic = 8
      garlic = UserIngredient.new(:user_id => id, :ingredient_id =>8 , :unit => "small", :qty => 3 )
      garlic.save

      #salt = 9
      salt = UserIngredient.new(:user_id => id, :ingredient_id =>9 , :unit => "kg", :qty => 1 )
      salt.save

      #pepper = 10
      pepper = UserIngredient.new(:user_id => id, :ingredient_id =>10 , :unit => "g", :qty => 500 )
      pepper.save

      #15 = eggs
      eggs = UserIngredient.new(:user_id => id, :ingredient_id =>15 , :unit => "medium", :qty => 12 )
      eggs.save

      #17 = apples
      apples = UserIngredient.new(:user_id => id, :ingredient_id =>17 , :unit => "large", :qty => 10 )
      apples.save

      #24 = white rice
      whiterice = UserIngredient.new(:user_id => id, :ingredient_id =>24 , :unit => "kg", :qty => 5 )
      whiterice.save

      #27 = pasta
      pasta = UserIngredient.new(:user_id => id, :ingredient_id =>27 , :unit => "kg", :qty => 1 )
      pasta.save

      #31 = flour
      flour = UserIngredient.new(:user_id => id, :ingredient_id =>31 , :unit => "kg", :qty => 2 )
      flour.save

      #34 = white sugar
      whitesugar = UserIngredient.new(:user_id => id, :ingredient_id =>34 , :unit => "kg", :qty => 1 )
      whitesugar.save

    end

  protected
    
    def make_activation_code
        self.activation_code = self.class.make_token
    end

    


end
