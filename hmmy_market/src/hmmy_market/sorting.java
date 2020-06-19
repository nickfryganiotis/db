package hmmy_market;
import java.util.*;
public class sorting {
	private ArrayList<String> cities= new ArrayList<String>();;
	private ArrayList<String> addresses = new ArrayList<String>();
	public sorting(ArrayList<String> Cities,ArrayList<String> Addresses) {
		cities = Cities;
		addresses = Addresses;
	}
	public void merge(int low,int mid,int up) {
		int xmid = mid-low;
		int xup = up-low;
		int i=0;
		int j=xmid+1;
		int k = low;
		String[] X_1 = new String[up-low+1];
		String[] X_2 = new String[up-low+1];
		for(int t =0; t<=xup; t++) {
			X_1[t] = cities.get(low+t);
			X_2[t] = addresses.get(low+t);
		}
		while((i<=xmid)&(j<=xup)) {
			if(X_1[i].compareTo(X_1[j])<=0) {
				cities.set(k, X_1[i]);
				addresses.set(k, X_2[i]);
			    k++;
			    i++;
			}
			else {
				cities.set(k, X_1[j]);
				addresses.set(k, X_2[j]);
				k++;
				j++;
			}
		}
		if(i>mid) {
			for(int q=j; q<=xup; q++) {
				cities.set(k, X_1[q]);
				addresses.set(k, X_2[q]);
				k++;
			}
		}
		else {
			for(int q=i; q<=xmid; q++) {
				cities.set(k, X_1[q]);
				addresses.set(k, X_2[q]);
				k++;
			}
		}
	}
	public void mergesort(int left,int right) {
		if(left>=right) {
			return;
		}
		int mid = (left+right)/2;
		mergesort(left,mid);
		mergesort(mid+1,right);
		merge(left,mid,right);
	}
	public ArrayList<String> getCities(){
		return cities;
	}
	public ArrayList<String> getAddresses(){
		return addresses;
	}
	
	/*public static void main(String[] args) {
		ArrayList<String> city = new ArrayList<String>();
		city.add("Salonika");
		city.add("Athens");
		city.add("Patra");
		sorting s=new sorting(city);
		s.mergesort(0,city.size()-1);
		System.out.println(s.get());
	}*/
};