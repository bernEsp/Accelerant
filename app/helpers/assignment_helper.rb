module AssignmentHelper

  def size_helper(user)
    if user.participant
      size = [585, 465]
    else
      size = [440, 310]
    end
  end

end
