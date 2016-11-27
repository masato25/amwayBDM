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

* Update touch & screen to detail on plain `${url}/plains/${plain_id}/update`
  * ex. plains/1/update
  ```
  {
    "details": [
      {"identity_id":1, "TouchRect": "rect(2731,379,100,150)", "ScreenIndex": 3},
      {"identity_id": 2, "ScreenIndex": 2}
    ]
  }
  ```
