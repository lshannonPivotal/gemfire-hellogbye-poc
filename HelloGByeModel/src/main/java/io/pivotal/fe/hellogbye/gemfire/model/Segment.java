package io.pivotal.fe.hellogbye.gemfire.model;
import java.util.List;


/**
 * Pojo to represent a segment, this is really just a container to get the dota into the grid as
 * PDXSerialization will be used in the clients to work with the data
 * @author lshannon
 *
 */
public class Segment {
	private String AvailableFlightId;
	private String Origin;
	private String Destination;
	private String DepartureDate;
	private Long DepartureTime;
	private String ArrivalDate;
	private Long ArrivalTime;
	private Long TravelTime;
	private String Carrier;
	private int NoOfLegs;
	private String CitySeq;
	private Double OneWayFare;
	private Double ReturnFare;
	private String FareClass;
	private String FarePreference;
	private List<Segment> Legs;
	public String getAvailableFlightId() {
		return AvailableFlightId;
	}
	public void setAvailableFlightId(String availableFlightId) {
		AvailableFlightId = availableFlightId;
	}
	public String getOrigin() {
		return Origin;
	}
	public void setOrigin(String origin) {
		Origin = origin;
	}
	public String getDestination() {
		return Destination;
	}
	public void setDestination(String destination) {
		Destination = destination;
	}
	public String getDepartureDate() {
		return DepartureDate;
	}
	public void setDepartureDate(String departureDate) {
		DepartureDate = departureDate;
	}
	public Long getDepartureTime() {
		return DepartureTime;
	}
	public void setDepartureTime(Long departureTime) {
		DepartureTime = departureTime;
	}
	public String getArrivalDate() {
		return ArrivalDate;
	}
	public void setArrivalDate(String arrivalDate) {
		ArrivalDate = arrivalDate;
	}
	public Long getArrivalTime() {
		return ArrivalTime;
	}
	public void setArrivalTime(Long arrivalTime) {
		ArrivalTime = arrivalTime;
	}
	public Long getTravelTime() {
		return TravelTime;
	}
	public void setTravelTime(Long travelTime) {
		TravelTime = travelTime;
	}
	public String getCarrier() {
		return Carrier;
	}
	public void setCarrier(String carrier) {
		Carrier = carrier;
	}
	public int getNoOfLegs() {
		return NoOfLegs;
	}
	public void setNoOfLegs(int noOfLegs) {
		NoOfLegs = noOfLegs;
	}
	public String getCitySeq() {
		return CitySeq;
	}
	public void setCitySeq(String citySeq) {
		CitySeq = citySeq;
	}
	public Double getOneWayFare() {
		return OneWayFare;
	}
	public void setOneWayFare(Double oneWayFare) {
		OneWayFare = oneWayFare;
	}
	public Double getReturnFare() {
		return ReturnFare;
	}
	public void setReturnFare(Double returnFare) {
		ReturnFare = returnFare;
	}
	public String getFareClass() {
		return FareClass;
	}
	public void setFareClass(String fareClass) {
		FareClass = fareClass;
	}
	public String getFarePreference() {
		return FarePreference;
	}
	public void setFarePreference(String farePreference) {
		FarePreference = farePreference;
	}
	public List<Segment> getLegs() {
		return Legs;
	}
	public void setLegs(List<Segment> legs) {
		Legs = legs;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((ArrivalDate == null) ? 0 : ArrivalDate.hashCode());
		result = prime * result
				+ ((ArrivalTime == null) ? 0 : ArrivalTime.hashCode());
		result = prime
				* result
				+ ((AvailableFlightId == null) ? 0 : AvailableFlightId
						.hashCode());
		result = prime * result + ((Carrier == null) ? 0 : Carrier.hashCode());
		result = prime * result + ((CitySeq == null) ? 0 : CitySeq.hashCode());
		result = prime * result
				+ ((DepartureDate == null) ? 0 : DepartureDate.hashCode());
		result = prime * result
				+ ((DepartureTime == null) ? 0 : DepartureTime.hashCode());
		result = prime * result
				+ ((Destination == null) ? 0 : Destination.hashCode());
		result = prime * result
				+ ((FareClass == null) ? 0 : FareClass.hashCode());
		result = prime * result
				+ ((FarePreference == null) ? 0 : FarePreference.hashCode());
		result = prime * result + ((Legs == null) ? 0 : Legs.hashCode());
		result = prime * result + NoOfLegs;
		result = prime * result
				+ ((OneWayFare == null) ? 0 : OneWayFare.hashCode());
		result = prime * result + ((Origin == null) ? 0 : Origin.hashCode());
		result = prime * result
				+ ((ReturnFare == null) ? 0 : ReturnFare.hashCode());
		result = prime * result
				+ ((TravelTime == null) ? 0 : TravelTime.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Segment other = (Segment) obj;
		if (ArrivalDate == null) {
			if (other.ArrivalDate != null)
				return false;
		} else if (!ArrivalDate.equals(other.ArrivalDate))
			return false;
		if (ArrivalTime == null) {
			if (other.ArrivalTime != null)
				return false;
		} else if (!ArrivalTime.equals(other.ArrivalTime))
			return false;
		if (AvailableFlightId == null) {
			if (other.AvailableFlightId != null)
				return false;
		} else if (!AvailableFlightId.equals(other.AvailableFlightId))
			return false;
		if (Carrier == null) {
			if (other.Carrier != null)
				return false;
		} else if (!Carrier.equals(other.Carrier))
			return false;
		if (CitySeq == null) {
			if (other.CitySeq != null)
				return false;
		} else if (!CitySeq.equals(other.CitySeq))
			return false;
		if (DepartureDate == null) {
			if (other.DepartureDate != null)
				return false;
		} else if (!DepartureDate.equals(other.DepartureDate))
			return false;
		if (DepartureTime == null) {
			if (other.DepartureTime != null)
				return false;
		} else if (!DepartureTime.equals(other.DepartureTime))
			return false;
		if (Destination == null) {
			if (other.Destination != null)
				return false;
		} else if (!Destination.equals(other.Destination))
			return false;
		if (FareClass == null) {
			if (other.FareClass != null)
				return false;
		} else if (!FareClass.equals(other.FareClass))
			return false;
		if (FarePreference == null) {
			if (other.FarePreference != null)
				return false;
		} else if (!FarePreference.equals(other.FarePreference))
			return false;
		if (Legs == null) {
			if (other.Legs != null)
				return false;
		} else if (!Legs.equals(other.Legs))
			return false;
		if (NoOfLegs != other.NoOfLegs)
			return false;
		if (OneWayFare == null) {
			if (other.OneWayFare != null)
				return false;
		} else if (!OneWayFare.equals(other.OneWayFare))
			return false;
		if (Origin == null) {
			if (other.Origin != null)
				return false;
		} else if (!Origin.equals(other.Origin))
			return false;
		if (ReturnFare == null) {
			if (other.ReturnFare != null)
				return false;
		} else if (!ReturnFare.equals(other.ReturnFare))
			return false;
		if (TravelTime == null) {
			if (other.TravelTime != null)
				return false;
		} else if (!TravelTime.equals(other.TravelTime))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "Segment [AvailableFlightId=" + AvailableFlightId + ", Origin="
				+ Origin + ", Destination=" + Destination + ", DepartureDate="
				+ DepartureDate + ", DepartureTime=" + DepartureTime
				+ ", ArrivalDate=" + ArrivalDate + ", ArrivalTime="
				+ ArrivalTime + ", TravelTime=" + TravelTime + ", Carrier="
				+ Carrier + ", NoOfLegs=" + NoOfLegs + ", CitySeq=" + CitySeq
				+ ", OneWayFare=" + OneWayFare + ", ReturnFare=" + ReturnFare
				+ ", FareClass=" + FareClass + ", FarePreference="
				+ FarePreference + ", Legs=" + Legs + "]";
	}
	
}
