class User < ApplicationRecord
    validates :password, confirmation: true

    validates :email, presence: true, 
               uniqueness: true, 
               format: { 
               with: URI::MailTo::EMAIL_REGEXP, 
               message: '格式有誤' 
               }

    before_create :encrypt_password

    def encrypt_password  
        pw = "x#{self.password}y".reverse
        self.password = Digest::SHA1.hexdigest(pw)
    end

    def self.login( email, password )
        return nill if email.empty? or password.empty?

        password = "x#{password}y".reverse
        password = Digest::SHA1.hexdigest(password)

        find_by(email: email, password: password)
    end
end