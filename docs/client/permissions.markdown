---
layout: default
title: Permissions
nav_order: 5
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

# Permissions

## Add Permisssion to group
```ruby
['user', 'codeviewer', 'issueadmin', 'securityhotspotadmin', 'scan'].each do | permission |
  status = Sonarqube.permissions_add_group({groupName: 'New-Group', permission: permission, projectKey: 'test'})
  status.to_hash.nil?
end
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
```

## Add group to template
```ruby
['user', 'codeviewer', 'issueadmin', 'securityhotspotadmin', 'scan'].each do | permission |
  status = Sonarqube.add_group_to_template({groupName: 'New-Group', permission: permission, templateName: 'test'})
  status.to_hash.nil?
end
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
```

## Add project creator to template
```ruby
['user', 'codeviewer', 'issueadmin', 'securityhotspotadmin', 'scan'].each do | permission |
  status = Sonarqube.add_project_creator_to_template(permission, { templateName: 'test' })
  status.to_hash.nil?
end
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
```

## Add permissions to user
```ruby
['user', 'codeviewer', 'issueadmin', 'securityhotspotadmin', 'scan'].each do | permission |
  status = permission_add_user('user', permission, { templateName: 'test' })
  status.to_hash.nil?
end
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
```

## Add user to template
```ruby
['user', 'codeviewer', 'issueadmin', 'securityhotspotadmin', 'scan'].each do | permission |
  status = Sonarqube.add_user_to_template({ login: 'new_user', permission: 'user', templateName: 'test' })
  status.to_hash.nil?
end
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
```

## Apply Template
```ruby
status = Sonarqube.apply_template({ projectName: 'New-Group', templateName: 'test' })
status.to_hash.nil?
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
```

## Bulk apply template
```ruby
status = Sonarqube.bulk_apply_template({ templateName: 'test', projects: 'my_project,another_project' })
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
status.to_hash.nil?
```

## Create Template
```ruby
status = Sonarqube.create_template('template_name', 'description', '.*\.finance\..*')
# => #<Sonarqube::ObjectifiedHash:46120 {hash: {"permissionTemplate"=>{"id"=>"AXQt1hhmsmLGhox2KqqJ", "name"=>"template_name", "description"=>"description", "projectKeyPattern"=>".*\\.finance\\..*", "createdAt"=>"2020-08-27T02:53:59+0000", "updatedAt"=>"2020-08-27T02:53:59+0000", "permissions"=>[]}}}
status.permissionTemplate.name
# => template_name
```

## Delete Template
```ruby
status = Sonarqube.delete_template({ templateName: 'template_name' })
# => #<Sonarqube::ObjectifiedHash:46120 {hash: {"permissionTemplate"=>{"id"=>"AXQt1hhmsmLGhox2KqqJ", "name"=>"template_name", "description"=>"description", "projectKeyPattern"=>".*\\.finance\\..*", "createdAt"=>"2020-08-27T02:53:59+0000", "updatedAt"=>"2020-08-27T02:53:59+0000", "permissions"=>[]}}}
status.to_hash.nil?
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
```

## Remove group from template
```ruby
['user', 'codeviewer', 'issueadmin', 'securityhotspotadmin', 'scan'].each do | permission |
  status = Sonarqube.remove_group_from_template({groupName: 'New-Group', permission: permission, templateName: 'test'})
  status.to_hash.nil?
end
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
```

## Remove Permission from group
```ruby
['user', 'codeviewer', 'issueadmin', 'securityhotspotadmin', 'scan'].each do | permission |
  status = Sonarqube.permissions_remove_group({groupName: 'New-Group', permission: permission, projectKey: 'test'})
  status.to_hash.nil?
end
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
```

# Internal Apis

* Use at your own risk; internal services are subject to change or removal without notice (Sonarqube info).

## api/permissions/groups

```ruby
['user', 'codeviewer', 'issueadmin', 'securityhotspotadmin', 'scan'].each do | permission |
  status = Sonarqube.permissions_add_group({groupName: 'New-Group', permission: permission, projectKey: 'test'})
  status.to_hash.nil?
end
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
# => <Sonarqube::ObjectifiedHash:46120 {hash: {}}
# => true
```