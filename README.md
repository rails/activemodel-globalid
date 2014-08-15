# MOVED

To GlobalID: https://github.com/rails/globalid

## Active Model: GlobalID -- find models by string references

GlobalID is a way of serializing a model into a string, which can then be used to look it up later,
without the caller having to know the class. This is helpful in many cases where you accept different
classes of objects, but want to do so through string references.

One example is jobs. We don't want to pass in full model objects to a job queue because the marshalling
of this object might well not be safe (given that the model object can hold references to database 
connections or other assets). So instead we pass a GlobalID that can use used to look-up the model when
its time to perform the job.

Another example is a drop-down list of options with Users and Groups. By serializing both models with
GlobalID, we can make a receiver that simply takes a GlobalID -- or in the case of data that's being
exposed to the world, a SignedGlobalID -- and we can deal easily with objects of both classes.


## Usage

You can mix in ActiveModel::GlobalIdentification into any model that supports being found with a #find(id)
method. This gem will automatically include that module into ActiveRecord::Base, so all records will
be able to use the following methods:

```ruby
person_gid = Person.find(5).global_id         # => <#ActiveModel::GlobalID ...
person_gid.to_s 					          # => "Person-5"
ActiveModel::GlobalLocator.locate(person_gid) # => <#Person id:5 ...
```

## Under development as a gem, targeted for Rails inclusion

GlobalID is being developed in a gem, but is intended to be included in Active Model as part of Rails 4.2.


## License

Active Model: GlobalID is released under the MIT license.
