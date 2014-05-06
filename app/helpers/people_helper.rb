module PeopleHelper

  def person_sex_icon(person)
    return if person.male.nil?
    icon=person.male? ? 'male' : 'female'
    fa_icon(icon)
  end
end
