module ::TokenDigest
  def self.generate
    Digest::SHA1.hexdigest([Time.now, rand].join)
  end
end
