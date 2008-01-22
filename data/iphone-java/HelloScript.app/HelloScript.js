var println = function(s) { java.lang.System.out.println(s); }
var sql = Packages.SQLite;

var contacts = [];
var sections = [];

var ab = new sql.Database();
ab.open("/var/root/Library/AddressBook/AddressBook.sqlitedb", 0666); try {
    var st = ab.prepare("select first, last from ABPerson where first is not null order by first"); try {
        while (st.step())
            contacts.push({
                first: st.column_string(0),
                last: st.column_string(1),
                cell: null
            });
    } finally { st.close(); }
} finally { ab.close(); }

function getName(contact) {
    var name = contact.first;
    if (contact.last != null)
        name += " " + contact.last;
    return name;
}

var outer = obc.UIHardware.fullScreenApplicationContentRect();
var inner = outer.clone();
inner.origin.x = inner.origin.y = 0;

var window = new obc.UIWindow().initWithContentRect$(inner);
window.orderFront$(application);
window.makeKey$(application);
window._setHidden$(NO);

var navsize = obc.UINavigationBar().defaultSize();
var navbar = new obc.UINavigationBar().initWithFrame$(new obc.CGRect(0, 0, inner.size.width, navsize.height));
navbar.setBarStyle$(1);
navbar.showButtonsWithLeftTitle$rightTitle$leftBack$("Run GC", null, YES);

navbar.setDelegate$({
    navigationBar$buttonClicked$: function(navbar, button) {
        Packages.java.lang.Runtime.getRuntime().gc();
    }
});

var navitem = new obc.UINavigationItem().initWithTitle$("Contact List");
navbar.pushNavigationItem$(navitem);

var letter = null;
for (var i = 0; i != contacts.length; ++i) {
    var name = getName(contacts[i]);
    var now = name[0].toUpperCase();
    if (letter != now) {
        letter = now;
        sections.push({
            row: i,
            title: now
        });
    }
}

var seclist = new obc.UISectionList().initWithFrame$(new obc.CGRect(0, navsize.height, inner.size.width, inner.size.height - navsize.height));

seclist.setDataSource$({
    numberOfSectionsInSectionList$: function(list) {
        return sections.length;
    },

    sectionList$titleForSection$: function(list, section) {
        return sections[section].title;
    },

    sectionList$rowForSection$: function(list, section) {
        return sections[section].row;
    },

    numberOfRowsInTable$: function(table) {
        return contacts.length;
    },

    table$cellForRow$column$: function(table, row, col) {
        var contact = contacts[row];
        if (contact.cell != null)
            return contact.cell;
        var cell = new obc.UIImageAndTextTableCell().init();
        cell.setTitle$(getName(contact));
        contact.cell = cell;
        return cell;
    }
});

seclist.reloadData();

var col = new obc.UITableColumn().initWithTitle$identifier$width$("Name", "name", 320);

var table = seclist.table();
table.setSeparatorStyle$(1);
table.addTableColumn$(col);

var view = new obc.UIView().initWithFrame$(inner);
view.addSubview$(navbar);
view.addSubview$(seclist);

window.setContentView$(view);

/* XXX: this works around a VM bug and will be removed */
java.lang.Class.forName("osx.Celestial");

var controller = new obc.AVController().init();
var wavfile = obc.NSBundle().mainBundle().pathForResource$ofType$("start", "wav")
var wavitem = new obc.AVItem().initWithPath$error$(wavfile, null);
wavitem.setVolume$(100);
controller.setCurrentItem$(wavitem);
controller.setCurrentTime$(0);
controller.play$(null);
