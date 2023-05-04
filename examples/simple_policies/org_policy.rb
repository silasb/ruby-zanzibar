class OrgPolicy
  include Zanzibar::Behavior

  define :owner, as: proc { _self }
  define :member, as: proc { _self || owner }
end