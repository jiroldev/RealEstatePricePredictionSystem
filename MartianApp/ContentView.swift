
import SwiftUI

struct ContentView: View {
    
    @State private var numberOfBedrooms: Double = 7.0
    @State private var numberOfBathrooms: Double = 4.0
    @State private var propertyType: Double = 1.0
    @State private var location: Double = 0.0
    @State private var area: String = ""
    @State private var parking: Double = 1.0
    @State private var pool: Double = 0.0
    @State private var predictedPrice: String = ""
    
    let model: RealEstatePrices = try! RealEstatePrices(configuration: .init())
    
    var body: some View {
    
        NavigationView {
                
                VStack {
                    VStack(alignment: .leading, spacing: 25) {
                        
                        Form{
                            Text("Property Type")
                                .fontWeight(.bold)
                            Picker("", selection: self.$propertyType) {
                                Text("House").tag(1.0)
                                Text("Condo").tag(2.0)
                                Text("Land").tag(3.0)
                            }.pickerStyle(SegmentedPickerStyle())
                            
                            Picker(selection: $location, label: Text("Location").fontWeight(.bold)) {
                                Text("Asisan").tag(1.0)
                                Text("Calabuso").tag(2.0)
                                Text("Iruhin South").tag(3.0)
                                Text("Iruhin West").tag(4.0)
                                Text("Kaybagal South").tag(5.0)
                                Text("Laurel").tag(6.0)
                                Text("San Jose").tag(7.0)
                                Text("Silang Junction North").tag(8.0)
                                Text("Sungay North").tag(9.0)
                                Text("Talisay").tag(10.0)
                            }
                            
                        }.navigationBarTitle("Tagaytay Real Estate")
                        
                        Text("  Number of Bedrooms        Number of Bathrooms")
                            .fontWeight(.bold)
                        GeometryReader { geometry in
                            HStack {
                                Picker(
                                    selection: $numberOfBedrooms,
                                    label: Text(""),
                                    content: {
                                         Text("1 BR").tag(1.0)
                                         Text("2 BR").tag(2.0)
                                         Text("3 BR").tag(3.0)
                                         Text("4 BR").tag(4.0)
                                         Text("5 BR").tag(5.0)
                                         Text("6 BR").tag(6.0)
                                         Text("7 BR").tag(7.0)
                                         Text("8 BR").tag(8.0)
                                         Text("9 BR").tag(9.0)
                                         Text("10 BR").tag(10.0)
                                })
                                .frame(width: geometry.size.width/2.1, height: 100, alignment: .center)
                                .pickerStyle(WheelPickerStyle())
                                
                                Picker(
                                    selection: $numberOfBathrooms,
                                    label: Text(""),
                                    content: {
                                         Text("1 BT").tag(1.0)
                                         Text("2 BT").tag(2.0)
                                         Text("3 BT").tag(3.0)
                                         Text("4 BT").tag(4.0)
                                         Text("5 BT").tag(5.0)
                                         Text("6 BT").tag(6.0)
                                         Text("7 BT").tag(7.0)
                                         Text("8 BT").tag(8.0)
                                         Text("9 BT").tag(9.0)
                                         Text("10 BT").tag(10.0)
                                })
                                .pickerStyle(WheelPickerStyle())
                                .frame(width: geometry.size.width/2, height: 100, alignment: .center)
                            }
                        }
                        /*Text("Number of Bedrooms")
                            .fontWeight(.bold)
                        Picker("Number of Bedrooms", selection: self.$numberOfBedrooms) {
                            Text("1").tag(1.0)
                            Text("2").tag(2.0)
                            Text("3").tag(3.0)
                            Text("4").tag(4.0)
                            Text("5").tag(5.0)
                            Text("6").tag(6.0)
                            Text("7").tag(7.0)
                            Text("8").tag(8.0)
                            Text("9").tag(9.0)
                            Text("10").tag(10.0)
                        }.pickerStyle(SegmentedPickerStyle())*/
                        
                        /*Text("Number of Bathrooms")
                            .fontWeight(.bold)
                        Picker("Number of Solar Panels", selection: self.$numberOfBathrooms) {
                            Text("1").tag(1.0)
                            Text("2").tag(2.0)
                            Text("3").tag(3.0)
                            Text("4").tag(4.0)
                            Text("5").tag(5.0)
                            Text("6").tag(6.0)
                            Text("7").tag(7.0)
                            Text("8").tag(8.0)
                            Text("9").tag(9.0)
                            Text("10").tag(10.0)
                        }.pickerStyle(SegmentedPickerStyle())*/
                        
                        Group {
                            Text("Land Area")
                                .fontWeight(.bold)
                            TextField("square meter", text: self.$area)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        Text("Parking")
                            .fontWeight(.bold)
                        Picker("Parking", selection: self.$parking) {
                            Text("Yes").tag(1.0)
                            Text("No").tag(0.0)
                        }.pickerStyle(SegmentedPickerStyle())
                        
                        Text("Pool")
                            .fontWeight(.bold)
                        Picker("", selection: self.$pool) {
                            Text("Yes").tag(1.0)
                            Text("No").tag(0.0)
                        }.pickerStyle(SegmentedPickerStyle())
                        
                        
                        
                        
        
                    }.padding()
                    
                    Button("Calculate Price") {
                        
                            let output =  try? self.model.prediction(
                                Property_Type: self.propertyType, Location: self.location,
                                Bedrooms: self.numberOfBedrooms,
                                Bathrooms: self.numberOfBathrooms,
                                Area: Double(self.area) ?? 100,
                                Parking: self.parking,
                                Pool: self.pool)
                        
                            if let output = output {
                                 self.predictedPrice = output.Price < 0 ? "N/A" : "₱\(output.Price.withCommas())"
                            }
                        }
                        .padding(10)
                        .background(Color.green)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        
                        
                    
                    Spacer()
                    
                    Text(self.predictedPrice)
                        .font(.title)
                    
                    Spacer()
                }
            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
