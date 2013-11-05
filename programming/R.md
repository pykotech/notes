R Tips
======

Data Frames
-----------

### Get rows with unique id's

    subset(data,!duplicated(data$ID))

### Get subset of rows

    # don't forget to include the trailing comma!
    data[data$var > 5,]

    # another way
    subset(data, x > 5 & y > 3)

### "List comprehension"

    # just a hack
    x = 1:100
    y = unlist(Map(someFunction, x))
    
  http://stackoverflow.com/questions/8745972/rewrite-this-list-comprehension-in-r

Package Management
------------------

### Build a package

    R CMD INSTALL --build
