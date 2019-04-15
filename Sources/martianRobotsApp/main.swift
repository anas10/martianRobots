import martianRobotsLib

let main = {
    let parser: ParserType = Parser()
    let processor = Processor()

    print("Enter your instructions:")
    parser.parseInput()
    processor.process(mars: parser.mars)
}

main()
