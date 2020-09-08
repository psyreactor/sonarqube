---
layout: default
title: Groups
nav_order: 2
parent: Client
---

<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# Groups

## Create Group
```ruby
group = Sonarqube.create_group('New-Group', {description: 'Sonarqube group users'})
# => #<Sonarqube::ObjectifiedHash:46500 {hash: {"group"=>{"uuid"=>"AXQYrrgCsrvdoo0YodNM", "organization"=>"default-organization", "name"=>"New-Group", "description"=>"Sonarqube group users", "membersCount"=>0, "default"=>false}}}
group.group.uuid
# AXQYrrgCsrvdoo0YodNM
group.group.description
# Sonarqube group users
```

## Delete Group
```ruby
group = Sonarqube.group_delete('New-Group')
# => #<Sonarqube::ObjectifiedHash:46220 {hash: {}}
group.to_hash.empty?
# => true
```

## Search Group
```ruby
groups = Sonarqube.search_groups({ q: 'sonar-users' })
# => #<Sonarqube::ObjectifiedHash:46520 {hash: {"paging"=>{"pageIndex"=>1, "pageSize"=>100, "total"=>1}, "groups"=>[{"uuid"=>"AXOt93S3gMZPhbn-E_O7", "name"=>"sonar-users", "description"=>"Any new users created will automatically join this group", "membersCount"=>5, "default"=>true}]}}
groups.groups.each do | group |
  puts "name: #{group.name}"
  puts "description: #{group.description}"
  puts "membersCount: #{group.membersCount}"
end
# name: sonar-users
# description: Any new users created will automatically join this group
# MembersCount: 5
```

## Update Group
```ruby
group = Sonarqube.group_members('AXQRcKrW9pRiZzanEJ2E', { description: 'update group description' })
# => #<Sonarqube::ObjectifiedHash:46080 {hash: {"group"=>{"uuid"=>"AXQRcKrW9pRiZzanEJ2E", "organization"=>"default-organization", "name"=>"Sonarqube-Group", "description"=>"update group description'", "membersCount"=>0, "default"=>false}}}
group.group.uuid
# AXQRcKrW9pRiZzanEJ2E
group.group.description
# update group description
```
## Add Member
```ruby
group = Sonarqube.add_member('AXQRcKrW9pRiZzanEJ2E', 'test-user')
# => #<Sonarqube::ObjectifiedHash:46220 {hash: {}}
group.to_hash.empty?
# => true
group = Sonarqube.add_member(nil, 'test-user', {name: 'sonar-groups'})
# => #<Sonarqube::ObjectifiedHash:46220 {hash: {}}
group.to_hash.empty?
# => true
```

## Remove Member
```ruby
group = Sonarqube.remove_member('AXQRcKrW9pRiZzanEJ2E', 'test-user')
# => #<Sonarqube::ObjectifiedHash:46220 {hash: {}}
group.to_hash.empty?
# => true
group = Sonarqube.remove_member('AXQRcKrW9pRiZzanEJ2E', 'test-user', {name: 'sonar-groups'})
# => #<Sonarqube::ObjectifiedHash:46220 {hash: {}}
group.to_hash.empty?
# => true
```

## List Members
```ruby
group = Sonarqube.list_members({name: 'sonar-groups'})
# => #<Sonarqube::ObjectifiedHash:46080 {hash: {"users"=>[{"login"=>"admin", "name"=>"Administrator", "selected"=>true}, {"login"=>"new_user", "name"=>"key_new_user", "selected"=>true}, {"login"=>"login_name", "name"=>"name_user", "selected"=>true}, {"login"=>"newlogin", "name"=>"test QA", "selected"=>true}, {"login"=>"test4", "name"=>"user test", "selected"=>true}], "p"=>1, "ps"=>25, "total"=>5}}
groups.users.each do | user |
  puts "name: #{user.name}"
  puts "login: #{user.login}"
end
# name: Administrator
# login: admin
# name: name_user
# login: login_name
# name: test QA
# login: newlogin
# name: user test
# login: test4
```