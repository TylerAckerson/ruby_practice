class Card
  attr_reader :face_value
  attr_accessor :hidden

  def initialize(face_value)
    @face_value = face_value
    @hidden = true
  end

  def hide
    self.hidden = true
  end

  def reveal
    self.hidden = false
    face_value
  end

  def to_s
    face_value.to_s
  end
  
  # def ==(other_card)
  #   other_card.face_value == self.face_value
  # end

end
