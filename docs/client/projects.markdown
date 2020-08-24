---
layout: default
title: Projects
nav_order: 3
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


# Projects

## Create Project
```ruby
project = Sonarqube.project_create('new_project')
# => <Sonarqube::ObjectifiedHash:46200 {hash: {"project"=>{"key"=>"new_project", "name"=>"new_project", "qualifier"=>"TRK", "visibility"=>"public"}}}
project.project.key
# => "new_project"
project.to_hash
# => {"project"=>{"key"=>"new_project", "name"=>"new_project", "qualifier"=>"TRK", "visibility"=>"public"}}
```

## Delete Project
```ruby
project = Sonarqube.project_delete('test')
# => #<Sonarqube::ObjectifiedHash:46220 {hash: {}}
project.to_hash.empty?
# => true
```

## Search Project
```ruby
projects = Sonarqube.project_search()
# => #<Sonarqube::ObjectifiedHash:46240 {hash: {"paging"=>{"pageIndex"=>1, "pageSize"=>100, "total"=>2}, "components"=>[{"organization"=>"default-organization", "key"=>"old_key", "name"=>"new_proyect", "qualifier"=>"TRK", "visibility"=>"private"}, {"organization"=>"default-organization", "key"=>"test", "name"=>"test", "qualifier"=>"TRK", "visibility"=>"public"}]}}
projects.components.each do | project |
  puts "name: #{project.name}"
  puts "key: #{project.key}"
end
# name: new_proyect
# key: old_key
# name: test
# key: test
```

## Update project key.
```ruby
Sonarqube.project_update_key('key_ori', 'key_new')
# => #<Sonarqube::ObjectifiedHash:46220 {hash: {}}
project.to_hash.empty?
# => true
```

## Update  project visibility.
```ruby
Sonarqube.project_update_visibility('sonarqube', 'public')
# => #<Sonarqube::ObjectifiedHash:46220 {hash: {}}
project.to_hash.empty?
# => true
```

## Bulk delete projects.
```ruby
projects = Sonarqube.projects_bulk_delete({projects: 'new_proyect'})
# => #<Sonarqube::ObjectifiedHash:46220 {hash: {}}
project.to_hash.empty?
# => true
```