import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dixapp/util/country_picker/country.dart';
import 'package:diacritic/diacritic.dart';

export 'package:dixapp/util/country_picker/country.dart';

const _platform = const MethodChannel('dixapp/util/flutter_country_picker');
Future<List<Country>> _fetchLocalizedCountryNames() async {
  List<Country> renamed = new List();
  Map result;
  try {
    var isoCodes = <String>[];
    Country.ALL.forEach((Country country) {
      isoCodes.add(country.isoCode);
    });
    result = await _platform.invokeMethod(
        'getCountryNames', <String, dynamic>{'isoCodes': isoCodes});
  } on PlatformException catch (e) {
    return Country.ALL;
  }

  for (var country in Country.ALL) {
    renamed.add(country.copyWith(name: result[country.isoCode]));
  }
  renamed.sort(
      (Country a, Country b) => removeDiacritics(a.name).compareTo(b.name));

  return renamed;
}

/// The country picker widget exposes an dialog to select a country from a
/// pre defined list, see [Country.ALL]
class CountryPicker extends StatelessWidget {
  const CountryPicker({
    Key key,
    this.selectedCountry,
    @required this.onChanged,
    this.dense = false,
  }) : super(key: key);

  final Country selectedCountry;
  final ValueChanged<Country> onChanged;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    Country displayCountry = selectedCountry;

    if (displayCountry == null) {
      displayCountry =
          Country.findByIsoCode(Localizations.localeOf(context).countryCode);
    }

    return dense
        ? _renderDenseDisplay(context, displayCountry)
        : _renderDefaultDisplay(context, displayCountry);
  }

  _renderDefaultDisplay(BuildContext context, Country displayCountry) {
    return InkWell(

      child: new Container(
        width: 138.0,
        height: 60.0,
        padding: EdgeInsets.only(left:8.0, right: 8.0),
        decoration: BoxDecoration(
            color: Colors.green[50],
            shape: BoxShape.rectangle,
            border: Border.all(width: 1.0, color: Colors.green[50]),
            borderRadius: BorderRadius.circular(10.0)),
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

           new Container(
             width: 120.0,
             height: 60.0,
             child: new Row(
               children: <Widget>[
                 Image.asset(
                   displayCountry.asset,
                   height: 25.0,
                   fit: BoxFit.fitWidth,
                 ),
                 Container(
                     margin: const EdgeInsets.only(top:8.0,bottom: 8.0),
                     width: 53.0,
                     child: Text(" +${displayCountry.dialingCode}", style: TextStyle(fontSize: 18.0 , color: Colors.black,fontFamily: 'Montserrat'),)
                 ),
                 Icon(Icons.arrow_drop_down,color: Colors.black,size: 36.0,)
               ],
             ),
           ),
          ],
        ),
      ),
      onTap: () {
        _selectCountry(context, displayCountry);
      },
    );
  }

  _renderDenseDisplay(BuildContext context, Country displayCountry) {
    return InkWell(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            displayCountry.asset,
            package: "dixapp",
            height: 24.0,
            fit: BoxFit.fitWidth,
          ),
          Icon(Icons.arrow_drop_down,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade700
                  : Colors.white70),
        ],
      ),
      onTap: () {
        _selectCountry(context, displayCountry);
      },
    );
  }

  Future<Null> _selectCountry(
      BuildContext context, Country defaultCountry) async {
    final Country picked = await showCountryPicker(
      context: context,
      defaultCountry: defaultCountry,
    );

    if (picked != null && picked != selectedCountry) onChanged(picked);
  }
}

/// Display an [Dialog] with the country list to selection
/// you can pass and [defaultCountry], see [Country.findByIsoCode]
Future<Country> showCountryPicker({
  BuildContext context,
  Country defaultCountry,
}) async {
  assert(Country.findByIsoCode(defaultCountry.isoCode) != null);

  return await showDialog<Country>(
    context: context,
    builder: (BuildContext context) => _CountryPickerDialog(
          defaultCountry: defaultCountry,
        ),
  );
}

class _CountryPickerDialog extends StatefulWidget {
  const _CountryPickerDialog({
    Key key,
    Country defaultCountry,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<_CountryPickerDialog> {
  TextEditingController controller = new TextEditingController();
  String filter;
  List<Country> countries;

  @override
  void initState() {
    super.initState();

    countries = Country.ALL;

    _fetchLocalizedCountryNames().then((renamed) {
      setState(() {
        countries = renamed;
      });
    });

    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Dialog(
        child: Column(
          children: <Widget>[
            new TextField(
              decoration: new InputDecoration(
                hintText: MaterialLocalizations.of(context).searchFieldLabel,
                prefixIcon: Icon(Icons.search),
                suffixIcon: filter == null || filter == ""
                    ? Container(
                        height: 0.0,
                        width: 0.0,
                      )
                    : InkWell(
                        child: Icon(Icons.clear),
                        onTap: () {
                          controller.clear();
                        },
                      ),
              ),
              controller: controller,
            ),
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: countries.length,
                  itemBuilder: (BuildContext context, int index) {
                    Country country = countries[index];
                    if (filter == null ||
                        filter == "" ||
                        country.name
                            .toLowerCase()
                            .contains(filter.toLowerCase()) ||
                        country.isoCode.contains(filter)) {
                      return InkWell(
                        child: ListTile(
                          trailing: Text("+ ${country.dialingCode}"),
                          title: Row(
                            children: <Widget>[
                              Image.asset(
                                country.asset,
                                package: "dixapp",
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    country.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context, country);
                        },
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
