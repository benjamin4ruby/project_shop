# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'digest/sha2'

module PasswordHelper

  def PasswordHelper.update(password)
    hash = self.hash(password)
    return hash
  end

  def PasswordHelper.check(password, hash)
    if (self.hash(password) == hash)
      true
    else
      false
    end
  end

  protected

  def PasswordHelper.hash(password)
    Digest::SHA512.hexdigest("#{password}")
  end

end

