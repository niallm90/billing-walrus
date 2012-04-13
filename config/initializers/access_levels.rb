module AccessLevels

  UNVERIFIED = 0
  VERIFIED = 1
  ADMIN = 2
  SUPER_USER = 3

  HUMAN_READABLE = {
    UNVERIFIED => "Unverified",
    VERIFIED => "Verified",
    ADMIN => "Admin",
    SUPER_USER => "Super User"
  }

end
