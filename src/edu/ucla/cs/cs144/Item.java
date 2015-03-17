package edu.ucla.cs.cs144;


import java.lang.*;
import java.util.*;

import javax.xml.bind.annotation.*;
 
@XmlRootElement(name="Item")
public class Item {

    public static class Bids {
        @XmlElement(name="Bid")
        public List<Bid> bid = new ArrayList<Bid>();
    }
    public static class Bid {

        @XmlElement(name="Bidder")
        public List<Bidder> bidder = new ArrayList<Bidder>();
        @XmlElement(name="Time")
        public String Time;
        @XmlElement(name="Amount")
        public String Amount;
    }   
    public static class Bidder {
        @XmlAttribute(name="UserID")
        public String ID;
        @XmlAttribute(name="Rating")
        public String Rating;
        @XmlElement(name="Location")
        public String Location;
        @XmlElement(name="Country")
        public String Country;
    }

    public static class Location {
        @XmlValue
        public String Loc_Name;
        @XmlAttribute(name="Latitude")
        public String Latitude;
        @XmlAttribute(name="Longitude")
        public String Longitude;
    }

    public static class Seller {
        @XmlAttribute(name="UserID")
        public String UserID;
        @XmlAttribute(name="Rating")
        public String Rating;

        // @XmlElement(name="UserID")
        // public String getUserID() {
        //     return UserID;
        // }
    }   
 
    @XmlAttribute(name="ItemID")
    public String ItemID;


    @XmlElement(name="Name")
    public String Name;

    @XmlElement(name="Category")
    public List<String> Category = new ArrayList<String>();

    @XmlElement(name="Currently")
    public String Currently;

    @XmlElement(name="Buy_Price")
    public String Buy_Price;

    @XmlElement(name="First_Bid")
    public String First_Bid;

    @XmlElement(name="Number_of_Bids")
    public String Number_of_Bids;

    @XmlElement(name="Bids")
    public Bids bids;

    @XmlElement(name="Location")
    public Location Location;

    @XmlElement(name="Country")
    public String Country;

    @XmlElement(name="Started")
    public String Started;

    @XmlElement(name="Ends")
    public String Ends;

    @XmlElement(name="Seller")
    public Seller Seller;

    @XmlElement(name="Description")
    public String Description;

}



