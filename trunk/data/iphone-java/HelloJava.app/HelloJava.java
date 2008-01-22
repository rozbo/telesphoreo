import obc.*;
import joc.*;

import joc.Message;

import static joc.Pointer.*;
import static joc.Static.*;

import java.util.ArrayList;
import java.util.Date;

public class HelloJava
    extends UIApplication
{

private UIWindow window;

private static class Contact {
    public String first;
    public String last;
    public UITableCell cell;

    public Contact(String first, String last) {
        this.first = first;
        this.last = last;
        this.cell = null;
    }

    public String getName() {
        String name = first;
        if (last != null)
            name += " " + last;
        return name;
    }
}

public static class Section {
    public int row;
    public String title;

    public Section(int row, String title) {
        this.row = row;
        this.title = title;
    }
}

private ArrayList<Contact> contacts_ = new ArrayList<Contact>();
private ArrayList<Section> sections_ = new ArrayList<Section>();

@Message public void applicationDidFinishLaunching$(Object unused)
    throws Exception
{
    SQLite.Database ab = new SQLite.Database();
    ab.open("/var/root/Library/AddressBook/AddressBook.sqlitedb", 0666); try {
        SQLite.Stmt st = ab.prepare("select first, last from ABPerson where first is not null order by first"); try {
            while (st.step())
                contacts_.add(new Contact(st.column_string(0), st.column_string(1)));
        } finally { st.close(); }
    } finally { ab.close(); }

    CGRect outer = UIHardware.fullScreenApplicationContentRect();
    CGRect inner = outer.clone();
    inner.origin.x = inner.origin.y = 0;

    window = new UIWindow().initWithContentRect$(inner);
    window.orderFront$(this);
    window.makeKey$(this);
    window._setHidden$(NO);

    CGSize navsize = UINavigationBar.defaultSize();
    UINavigationBar navbar = new UINavigationBar().initWithFrame$(new CGRect(0, 0, inner.size.width, navsize.height));
    navbar.setBarStyle$(1);
    navbar.showButtonsWithLeftTitle$rightTitle$leftBack$("Run GC", null, YES);

    navbar.setDelegate$(new NSObject() {
        @Message void navigationBar$buttonClicked$(UINavigationBar navbar, int button) {
            java.lang.Runtime.getRuntime().gc();
        }
    }.init());

    UINavigationItem navitem = new UINavigationItem().initWithTitle$("Contact List");
    navbar.pushNavigationItem$(navitem);

    char letter = 0;
    for (int i = 0; i != contacts_.size(); ++i) {
        String name = contacts_.get(i).getName();
        char now = name.charAt(0);
        if (letter != now) {
            letter = now;
            sections_.add(new Section(
                i, new String(new char[] {now})
            ));
        }
    }

    UISectionList seclist = new UISectionList().initWithFrame$(new CGRect(0, navsize.height, inner.size.width, inner.size.height - navsize.height));

    seclist.setDataSource$(new NSObject() {
        @Message int numberOfSectionsInSectionList$(UISectionList list) {
            return sections_.size();
        }

        @Message String sectionList$titleForSection$(UISectionList list, int section) {
            return sections_.get(section).title;
        }

        @Message int sectionList$rowForSection$(UISectionList list, int section) {
            return sections_.get(section).row;
        }

        @Message int numberOfRowsInTable$(UITable table) {
            return contacts_.size();
        }

        @Message UITableCell table$cellForRow$column$(UITable table, int row, UITableColumn col) {
            Contact contact = contacts_.get(row);
            if (contact.cell != null)
                return contact.cell;
            UIImageAndTextTableCell cell = (UIImageAndTextTableCell) new UIImageAndTextTableCell().init();
            cell.setTitle$(contact.getName());
            contact.cell = cell;
            return cell;
        }
    }.init());

    seclist.reloadData();

    UITableColumn col = new UITableColumn().initWithTitle$identifier$width$("Name", "name", 320.0f);

    UITable table = (UITable) seclist.table();
    table.setSeparatorStyle$(1);
    table.addTableColumn$(col);

    UIView view = new UIView().initWithFrame$(inner);
    view.addSubview$(navbar);
    view.addSubview$(seclist);

    window.setContentView$(view);

    AVController controller = new AVController().init();
    CharSequence wavfile = (CharSequence) ((NSBundle) NSBundle.mainBundle()).pathForResource$ofType$("start", "wav");
    AVItem wavitem = new AVItem().initWithPath$error$(wavfile, null);
    wavitem.setVolume$(100);
    controller.setCurrentItem$(wavitem);
    controller.setCurrentTime$(0);
    controller.play$(null);
}

}
