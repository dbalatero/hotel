Q: What classes does each implementation include? Are the lists the same?
A: Each implementation includes the same classes: CartEntry, ShoppingCart, and Order. Not sure what is meant by 'lists'.

Q: Write down a sentence to describe each class.
A: For both implementations, the CartEntry class represents an item being added to an order, and takes in two arguments: unit_price and quantity. The ShoppingCart class holds an array of CartEntries. The Order class initializes a new instance of ShoppingCart and is able to calculate total_price of the order, factoring in sales_tax, a constant.

Q: How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
A: The classes in Implementation A are more tightly coupled than the classes in Implementation B. In A, the CartEntry and ShoppingCart classes have only states and no unique behavior, and they use attr_accessors for their instance variables, making them readable and writable from outside the class. The Order class has a total_price method that directly manipulates the two other class' instance variables through an each loop.
Implementation B has no attr_accessors and each class has its own method to calculate price for itself and send those messages to the other classes.
Both A & B call the ShoppingCart class directly by it's name in Order's constructor, and instance creation might be better off in it's own helper method?

Q: What data does each class store? How (if at all) does this differ between the two implementations?
A: Both implementations have an 'entries' instance variable which I assume holds a collection (array) of CartEntry objects. Both also have a constant called SALES-TAX which holds a float, and the CartEntry initialize method in both takes in a unit_price and quantity, data which is then stored in the corresponding instance variables. The cart instance variable also holds an instance of ShoppingCart. There doesn't appear to be a large difference between data storage across the two implementations.

Q: What methods does each class have? How (if at all) does this differ between the two implementations?
A: As I mentioned above, in Implementation A the behavior for the whole system is concentrated in the Order class, where the total_price method accesses information from the other two classes to calculate the total sum for the order. Implementation B, however, adds a price method to both the CartEntry class and the ShoppingCart class, which helps DRY up the total_price method in the Order class, and adheres more to the single responsibility principle.

Consider the Order#total_price method. In each implementation:

Q: Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
A: In A, the logic to compute price is retained in Order, whereas in B, the logic is delegated across all classes.

Q: Does total_price directly manipulate the instance variables of other classes?
A: In Implementation A, total_price does directly manipulate the instance variables of other classes, whereas B does not - it receives a message from cart, which receives a message from CartEntry.

Q: If we decide items are cheaper if bought in bulk, how would this change the code?
A: When items are purchased in bulk, typically the unit cost goes down as the quantity increases. Therefore, in Implementation B, in CartEntry's price method we would have to build in some conditional logic to check if 'quantity' was above a certain amount, and if so, then multiply the unit price by a percentage like .40 to reduce the per unit cost, then multiply that by the quantity. For Implementation A, similar logic would need to be added to the total_price method in Order, which would make the method a bit too long and doing things it shouldn't be doing, violating SRP.

Q: Which implementation is easier to modify?
A: I believe B is easier to modify.

Q: Which implementation better adheres to the single responsibility principle?
A: Implementation B.

Q: Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled
A: Implementation B is more loosely coupled because it has fewer dependencies and each class adheres more to SRP and knows less about the other objects.


Q: Identify one place in your Hotel project where a class takes on multiple roles, or directly modifies the attributes of another class. Describe what changes you would need to make to improve this design, and how the resulting design would be an improvement.
A:
I noticed that my FrontDesk class called Hotel::Block.new by name directly inside FrontDesk#create_block. I decided to wrap this instance creation inside a private helper method in FrontDesk class called #create_block (similar to the private create_reservation method for creating new instances of Hotel::Reservation), and renamed the main create_block method as “make_block”. I think this is an improvement because if Block were to change, it would be easier to update the helper method.

There were a few other observations that I had but did not act on:
I also noticed that both Reservation and Block classes have some similar behavior, including the #booked_for?(date) and #date_range methods and wondered if that duplication was acceptable given that the Reservation and Block objects are used differently.
I also noticed that FrontDesk has a number of methods whose purpose is to find available rooms, such as #find_available_room, which calls #available_rooms, which calls Room methods #available? and #not_blocked?. There are also the private methods #find_available_room_with_number and #find_room_with_block. And after reading POODR chapter 4, where Metz makes the suggestion of a TripFinder class for her code example, it made me wonder if all of this finding rooms behavior belonged in its own class like “RoomFinder” - but I’d like more feedback before I attempt to implement this.
I also considered that FrontDesk should probably have a way of calculating the total cost of a reservation, for when people checkout and pay; however, this was not part of the stated requirements so I’ll assume it should not be built.
