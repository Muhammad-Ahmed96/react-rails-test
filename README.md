# Project Management ( Rails + React )


### Backend
Navigate to Backend folder and Run the following commands to setup backend project, make sure backend server is running on PORT 3000
```
bundle install
rails db:create
rails db:migrate
rails db:seed
rails s
```
### Frontend
Navigate to Frontend folder and Run the following commands to setup frontend
```
npm install
npm run dev
```

### Sample Seed Data
```
Admin:
admin@email.com
123456

User:
user2@email.com
abc123
```

### API Documentation
```
  Swagger API documentation is available at the follwing end point
  http://localhost:3000/api-docs
```

### Rspec test
RSpec model and request specs are available, run the following command to run tests
```
rspec
```
