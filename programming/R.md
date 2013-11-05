R Tips
======

1. Get rows with unique id's

    subset(data,!duplicated(data$ID))

2. Get subset of rows

    # don't forget to include the trailing comma!
    data[data$var > 5,]
    
    # another way
    subset(data, x > 5 & y > 3)

3. "List comprehension"

    x = 1:100
    y = unlist(Map(someFunction, x))

4. Build package

    R CMD INSTALL --build
