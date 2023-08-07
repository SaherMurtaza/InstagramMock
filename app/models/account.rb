class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  
  has_many :posts
  has_many :likes
  has_many :comments       
  protected
    def password_required?
      confirmed? ? super : false
    end
    # describe '#set_reset_password_token' do
    #   it 'returns the plaintext token' do
    #     potential_token = subject.send(:set_reset_password_token)
    #     potential_token_digest = Devise.token_generator.digest(subject, :reset_password_token, potential_token)
    #     actual_token_digest = subject.reset_password_token
    #     expect(potential_token_digest).to eql(actual_token_digest)
    #   end
    # end
end
