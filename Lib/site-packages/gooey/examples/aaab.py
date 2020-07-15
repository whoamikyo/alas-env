from argparse import ArgumentParser

from gooey import Gooey, GooeyParser


@Gooey(program_name='some program',
       dump_build_config=True)
def main():
    someparser = GooeyParser(description='Some words')
    # someparsers = someparser.add_subparsers(dest='someplace', description="asdfasdfa", help="ASDOUHAS DIASUHD OSIAUDH SAOIUDH SAOIDUHS AODIUSHA D")
    # somesubparser = someparsers.add_parser('someoption', help='AAAAAH! CROCODILES! Someone help me!')
    # someothersubparser = someparsers.add_parser('someotheroption', help='foo')
    # someoption = somesubparser.add_argument('-somecrocodile', action='store_true', help='Nothing to see here, move along.')
    someparser.add_argument(
        '--filteroption', choices=["one","sku", "three"],
        help='Select the column name you want to filter data for:',
        widget='Listbox',
        required=False,
        nargs='*',
        metavar='Select Column Name',
        default=['sku', 'three'])
    someparser.parse_args()

    # for i in range(3):
    #     import time
    #     time.sleep(.3)
    #     print("Haillo", i)

    print("hai")


if __name__ == '__main__':
    main()