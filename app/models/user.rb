class User < ApplicationRecord
    #callback method
    before_create :encrypt_password
    
    #validatation
    validates :password, confirmation: true

    validates :email, presence: true, 
               uniqueness: true, 
               format: { 
               with: URI::MailTo::EMAIL_REGEXP, 
               message: '格式有誤' 
               }

    #relationships
    has_many :articles
    has_many :comments

    #class method
    def encrypt_password
        pw = "x#{self.password}y".reverse
        self.password = Digest::SHA1.hexdigest(pw)
    end

    def self.login( email, password )
        return nil if email.empty? or password.empty?

        password = Digest::SHA1.hexdigest("x#{password}y".reverse)

        find_by(email: email, password: password)
    end

    def display_name
        user_name.presence || email.split("@").first.capitalize
    end

    # before_create do encrypt_password(self.password) end

    # def encrypt_password(password)
    #     pw = "x#{password}y".reverse
    #     password = Digest::SHA1.hexdigest(pw)
    # end

    # def self.login( email, password )
    #     return nil if email.empty? or password.empty?

    #     password = Digest::SHA1.hexdigest("x#{password}y".reverse)
    #     password = encrypt_password(password)

    #     find_by(email: email, password: password)
    # end
end


