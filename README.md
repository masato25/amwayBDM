# AmwayBDM

```
gem install bundle
npm install yarn -g
```
```
cd $project_folder
bundle
rake db:migrate
rails s
$!! Series is up !!$
```
optional: {{if you have scert seeding data , please put it into db folder, then run `rake db:seed`. that will help to create sample demo data}}

## API refer
* Get sync data for one machine `${url}/machines/${machine_id}/sync`
  * ex. /machines/3/sync
