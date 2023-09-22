/*
    This program demonstrates how to write and 
    use a stack class based on linked lists.
*/

class LinkedStack
{
    /**
       The Node class is used to implement the 
		 linked list.
    */
    
    private class Node
    {
        String value;
        Node next;
        Node(String val, Node n)
        {
            value = val; 
            next = n;
        }       
    }
    
    private Node top = null;  // Top of the stack
    
    /**
       The empty method checks for an empty stack.
       @return true if stack is empty, false otherwise.
    */
    
    public boolean empty()
    {
        return top == null;
    }
    
    /**
       The push method adds a new item to the stack.
       @param s The item to be pushed onto the stack.
    */
    
    public void push(String s)
    {
        top = new Node(s, top);
    }
    
    /**
       The Pop method removes the value at the 
		 top of the stack.
       @return The value at the top of the stack.
		 @exception EmptyStackException When the 
		 stack is empty.
    */

    public String pop()
    {
        if (empty())
          throw new IllegalStateException();
        else
        {            
            String retValue = top.value;
            top = top.next;            
            return retValue;
        }         
    } 
    
    /** 
       The peek method returns the top value
		 on the stack.
       @return The value at the top of the stack.
		 @exception EmptyStackException When the 
		 stack is empty.
    */

    public String peek()
    {
       if (empty())
          throw new IllegalStateException();
       else
          return top.value;
    }
    
    /**
       The toString method computes a string 
		 representation of the contents of the stack.
       @return The string representation of the 
		 stack contents.
    */
    
    public String toString()
    {
        StringBuilder sBuilder = new StringBuilder();
        Node p = top;
        while (p != null)
        {
            sBuilder.append(p.value);            
            p = p.next;
            if (p != null)
				   sBuilder.append("\n");
        }
        return sBuilder.toString();
    }
}