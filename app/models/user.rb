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

    has_many :like_logs
    has_many :liked_articles, through: :like_logs, source: :article

    # instance methods
    def toggle_like(record)
        if liked?(record)
            unlike!(record) 
            return false
        else
            like!(record)
            return true
        end
    end

    def liked?(record)
        liked_articles.include?(record)
    end

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

    private
    
    def like!(record)
        liked_articles << record
    end
    
    def unlike!(record)
        liked_articles.destroy(record)
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


