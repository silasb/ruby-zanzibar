class FilePolicy
  include Zanzibar::Behavior

  define :owner, as: proc { _self }
  define :viewer, as: proc { _self || owner }
  define :writer, as: proc { _self || owner }
end